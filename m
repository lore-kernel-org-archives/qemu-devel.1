Received: from eggs.gnu.org ([2001:4830:134:3::10]:55292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dyQvk-0002mR-GD
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 19:12:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dyQvj-0003ox-QQ
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 19:12:20 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:43462)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carenas@gmail.com>) id 1dyQvj-0003nN-Jk
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 19:12:19 -0400
Received: by mail-wm0-x22e.google.com with SMTP id m72so3643746wmc.0
	for <qemu-devel@nongnu.org>; Sat, 30 Sep 2017 16:12:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1506784985-4107-1-git-send-email-zhuoweizhang@yahoo.com>
References: <1506784985-4107-1-git-send-email-zhuoweizhang@yahoo.com>
From: Carlo Arenas <carenas@gmail.com>
Date: Sat, 30 Sep 2017 16:12:17 -0700
Message-ID: <CAPUEspj9iBDMGi7vHPVu2dRNFXdJ0-paJbEzscFbhE3O-WM3VQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] syscall: fix special case of write(fd,
 NULL, 0)
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: zhuoweizhang@yahoo.com
Cc: qemu-devel@nongnu.org, riku.voipio@iki.fi, laurent@vivier.eu
List-ID: <qemu-devel.nongnu.org>

Reviewed-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
