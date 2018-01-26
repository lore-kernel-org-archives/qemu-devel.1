Received: from eggs.gnu.org ([2001:4830:134:3::10]:57779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ef0gK-0001dF-1T
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 04:52:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ef0gJ-0003Y5-4B
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 04:52:24 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:51041)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ef0gI-0003Xo-UN
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 04:52:23 -0500
Received: by mail-wm0-x235.google.com with SMTP id f71so106204wmf.0
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 01:52:22 -0800 (PST)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 26 Jan 2018 09:52:21 +0000
Message-ID: <CAJSP0QWfwAbQwDUH3-e87+fB+FLPjJT3tXjQcDpPrxf7Rk-0cw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] QEMU related blogs, all in once place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

If you want to follow blogs from QEMU contributors check out:

https://planet.virt-tools.org/

Daniel Berrange has provided the following steps for adding your own
blog to planet.virt-tools.org:

  $ git clone git://libvirt.org/virttools-planet.git

and add your blog info to updater/virt-tools/config.ini.

Optionally add a icon in updater/virt-tools/images/.

Then send the changes as a patch to libvir-list@redhat.com with git send-email.

Stefan
