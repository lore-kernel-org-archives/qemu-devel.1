Received: from eggs.gnu.org ([2001:4830:134:3::10]:50490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dl89I-00065g-6c
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 02:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dl89H-0006P2-Dg
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 02:31:20 -0400
Received: from mail-qk0-x22e.google.com ([2607:f8b0:400d:c09::22e]:38542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <batmanustc@gmail.com>)
	id 1dl89H-0006Or-7u
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 02:31:19 -0400
Received: by mail-qk0-x22e.google.com with SMTP id o184so7489944qkc.5
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 23:31:19 -0700 (PDT)
MIME-Version: 1.0
From: Sam <batmanustc@gmail.com>
Date: Fri, 25 Aug 2017 14:31:17 +0800
Message-ID: <CAOE=1Z0trKFwm__wTKHSTAUSt+r9SBjCwft3tA=i5vJaixuX8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Why got no response of vnc?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi all,

I'm starting vm using:

kvm]$ sudo /usr/local/bin/qemu-system-x86_64 -m 256 -hda test.qcow2 -cdrom
> CentOS-7-x86_64-DVD-1503-01.iso -boot d
> VNC server running on '127.0.0.1:5900'


then I start vnc client in another PC to connect 10.253.23.24:11800 and
10.253.23.24:5900, I got time out, why?
