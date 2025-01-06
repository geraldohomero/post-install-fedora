#include <gtk/gtk.h>

static void on_button_script_clicked(GtkWidget *widget, gpointer user_data)
{
  const char *script_cmd = (const char *)user_data;
  g_spawn_command_line_async(script_cmd, NULL);
}

static void on_activate(GtkApplication *app, gpointer user_data)
{
  GtkWidget *window = gtk_application_window_new(app);
  gtk_window_set_title(GTK_WINDOW(window), "Post-Inst");
  gtk_window_set_default_size(GTK_WINDOW(window), 300, 200);

  GtkWidget *vbox = gtk_box_new(GTK_ORIENTATION_VERTICAL, 5);
  gtk_container_add(GTK_CONTAINER(window), vbox);

  GtkWidget *button1 = gtk_button_new_with_label("Rodar Script 1");
  g_signal_connect(button1, "clicked", G_CALLBACK(on_button_script_clicked), "/caminho/para/script1.sh");
  gtk_box_pack_start(GTK_BOX(vbox), button1, FALSE, FALSE, 0);

  GtkWidget *button2 = gtk_button_new_with_label("Rodar Script 2");
  g_signal_connect(button2, "clicked", G_CALLBACK(on_button_script_clicked), "/caminho/para/script2.sh");
  gtk_box_pack_start(GTK_BOX(vbox), button2, FALSE, FALSE, 0);

  gtk_widget_show_all(window);
}

int main(int argc, char **argv)
{
  GtkApplication *app = gtk_application_new("com.exemplo.gtk", G_APPLICATION_DEFAULT_FLAGS);
  g_signal_connect(app, "activate", G_CALLBACK(on_activate), NULL);
  int status = g_application_run(G_APPLICATION(app), argc, argv);
  g_object_unref(app);
  return status;
}