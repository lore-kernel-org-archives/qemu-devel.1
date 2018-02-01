Received: from eggs.gnu.org ([2001:4830:134:3::10]:34830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nesrine.zouari@enis.tn>) id 1ehGp6-0008RF-LR
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 10:30:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nesrine.zouari@enis.tn>) id 1ehGp0-00008G-Li
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 10:30:48 -0500
Received: from mail-qk0-x22a.google.com ([2607:f8b0:400d:c09::22a]:44166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nesrine.zouari@enis.tn>)
	id 1ehGp0-00007w-Fh
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 10:30:42 -0500
Received: by mail-qk0-x22a.google.com with SMTP id n188so8475083qkn.11
	for <qemu-devel@nongnu.org>; Thu, 01 Feb 2018 07:30:41 -0800 (PST)
MIME-Version: 1.0
From: Nesrine Zouari <nesrine.zouari@enis.tn>
Date: Thu, 1 Feb 2018 16:30:10 +0100
Message-ID: <CAPHFV4=P3viF0m0PtqFZZ8_JNxy7G6kXdysYAfSsOJZe=2j7gw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Qemu Trace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vilanova@ac.upc.edu, stefanha@redhat.com

Hello,

I am a computer engineering student and I am actually working on my
graduation project at Lauterbach company. The project is about Qemu Trace
and as a future I would like to contribute this work to the main line.

My project is divided into two parts:

1/ Collecting the Guest trace data : The trace solution should be able to
provide:

            a/ Instruction flow Trace

            b/ Memory read/write access

            c/ Time Stamps.

            d/ For tracing rich operating systems that are using MMU, we
additionally need to trace the task switches.

2/ Sending the collected data to a third party tool for analysis.

My question is about the first part. I would like to know, which trace
backend that better fit my use case.


Regards,

-----------------------------------------------------------------------------------------

Nesrine ZOUARI
Computer Engineering Student
Department of Computer Engineering and Applied Mathematics
National Engineering School of Sfax (ENIS)
University of Sfax-Tunisia
Tel: +216 52 620 475
