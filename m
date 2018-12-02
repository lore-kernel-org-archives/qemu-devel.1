Received: from eggs.gnu.org ([2001:4830:134:3::10]:59900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lapointe.jonathan@gmail.com>) id 1gTQxf-0005jw-DE
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 07:35:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lapointe.jonathan@gmail.com>) id 1gTQxc-0008P0-9u
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 07:34:59 -0500
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733]:41429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lapointe.jonathan@gmail.com>)
	id 1gTQxc-0008Oo-5V
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 07:34:56 -0500
Received: by mail-qk1-x733.google.com with SMTP id 189so5791643qkj.8
	for <qemu-devel@nongnu.org>; Sun, 02 Dec 2018 04:34:55 -0800 (PST)
Received: from [192.168.0.100] (modemcable130.52-202-24.mc.videotron.ca.
	[24.202.52.130])
	by smtp.gmail.com with ESMTPSA id b6sm5085519qtq.29.2018.12.02.04.34.54
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sun, 02 Dec 2018 04:34:54 -0800 (PST)
Date: Sun, 02 Dec 2018 07:34:44 -0500
From: Jonathan Lapointe <lapointe.jonathan@gmail.com>
Message-Id: <1543754084.5692.0@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Qemu-devel] dual monitors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I would like to use my two monitors with qemu.  I was working before 
with qemu & virtio, but then the fullscreen mode was not a problem.  
But since, I have two monitors I cannot be in fullscreen mode otherwise 
I lost the other monitor, can't use it.  I heard that qxl could fix 
this. When I start qemu with qxl, I have no cursor visible and I get 
this message: qxl_cursor: not implemented: type 1.

My goal, would be to be able do fullscreen while with other monitor i 
could open a new session of qemu, or browse the web.
