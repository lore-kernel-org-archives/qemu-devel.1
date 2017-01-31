Received: from eggs.gnu.org ([2001:4830:134:3::10]:58854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYTDW-0005IH-FR
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 02:51:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYTDT-0005qw-BR
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 02:51:06 -0500
Message-ID: <1485849060.23903.15.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 31 Jan 2017 08:51:00 +0100
In-Reply-To: <1485826335-15686-1-git-send-email-skiver.cloud.yzy@gmail.com>
References: <1485826335-15686-1-git-send-email-skiver.cloud.yzy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] ui/gtk.c: add ctrl-alt-= support for zoom
 in acceleration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ziyue Yang <skiver.cloud.yzy@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Anthony Liguori <aliguori@us.ibm.com>, Thomas Huth <thuth@redhat.com>, Ziyue Yang <yzylivezh@hotmail.com>

On Di, 2017-01-31 at 09:32 +0800, Ziyue Yang wrote:
> From: Ziyue Yang <yzylivezh@hotmail.com>
>=20
> Solving wishlist item at
> https://bugs.launchpad.net/qemu/+bug/1656710
> by accepting Ctrl-Alt-=3D as an additional zoom-in acceleration.
>=20
> Using gtk_accel_group_connect to support multiple accelerations
> triggering a single menu item since that gtk_accel_map_add_entry
> seems to support only one acceleration. A wrapper function
> gd_accel_zoom_in is added to support gtk_accel_group_connect's
> callback activities.
>=20
> Signed-off-by: Ziyue Yang <skiver.cloud.yzy@gmail.com>

Added to UI queue.

thanks,
  Gerd
