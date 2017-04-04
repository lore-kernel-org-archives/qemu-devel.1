Received: from eggs.gnu.org ([2001:4830:134:3::10]:35667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ali.saeedi56@gmail.com>) id 1cvNZD-0005sR-17
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 08:28:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ali.saeedi56@gmail.com>) id 1cvNZC-0006SI-0I
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 08:28:11 -0400
Received: from mail-qk0-x235.google.com ([2607:f8b0:400d:c09::235]:33024)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ali.saeedi56@gmail.com>)
	id 1cvNZB-0006SD-RV
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 08:28:09 -0400
Received: by mail-qk0-x235.google.com with SMTP id h67so40695783qke.0
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 05:28:09 -0700 (PDT)
MIME-Version: 1.0
From: ali saeedi <ali.saeedi56@gmail.com>
Date: Tue, 4 Apr 2017 16:58:08 +0430
Message-ID: <CAGKXQycuTMYj2UrhWStNpj4ziDdHNd=JQwTQZgqJ2n9bshCd3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] Qemu VM Live Migration Code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello
I am a student who is interested in vm live migration. I want to understand
vm live migration code in qemu. so I tried to understand the code that is
available in 'migration.c' but it is very difficult for me to understand (I
have started from migration_thread function). I also has studied
migration.txt doc in docs folder. but i need more simple document to understand
the code. I know the basic for precopy, postcopy and hybrid algorithms of
vm live migration. I want to understand this implementation and implement
myown  idea by changing this code but I have problems for understanding it.
I also studied this link:
https://developers.redhat.com/blog/2015/03/24/live-
migrating-qemu-kvm-virtual-machines/
but i need more detail to  understand. I will be so grateful if anybody
recommend me a document, resource or any advice that help me for realizing
migration code in 'migration.c' ?
thanks a lot
