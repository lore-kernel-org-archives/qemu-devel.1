Received: from eggs.gnu.org ([2001:4830:134:3::10]:37914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shantanu16111994@gmail.com>) id 1deJgS-0005m4-0h
	for qemu-devel@nongnu.org; Sun, 06 Aug 2017 07:25:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shantanu16111994@gmail.com>) id 1deJgR-00034k-30
	for qemu-devel@nongnu.org; Sun, 06 Aug 2017 07:25:24 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:35147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shantanu16111994@gmail.com>)
	id 1deJgQ-00030i-VW
	for qemu-devel@nongnu.org; Sun, 06 Aug 2017 07:25:23 -0400
Received: by mail-oi0-x22b.google.com with SMTP id e124so46374607oig.2
	for <qemu-devel@nongnu.org>; Sun, 06 Aug 2017 04:25:21 -0700 (PDT)
MIME-Version: 1.0
From: Shantanu Agarwal <shantanu16111994@gmail.com>
Date: Sun, 6 Aug 2017 16:55:19 +0530
Message-ID: <CADsqsq+TieaYKCUDLetQR7QVkubTV4w+82ByAQGzrrM6ebcGYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Editing qemu source code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello all,
I was reading about qemu, trying to understand the source code. I found
that vl.c is considered the main file of qemu source code from where all
the execution starts. So I flipped some values, i even put a exit(0) just
after the int main starts, but nothing is changed. Qemu is fully
functional. Also i put many printf's in between but no output at all. Am I
missing something or vl.c is not the main file.

-- 
with regards,
Shantanu Agarwal
Mtech 2nd Year
+919958818058
IIT Delhi, New Delhi - 110016
