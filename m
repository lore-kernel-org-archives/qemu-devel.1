Received: from eggs.gnu.org ([2001:4830:134:3::10]:47971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shantanu16111994@gmail.com>) id 1daJh7-0001ok-6O
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 06:37:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shantanu16111994@gmail.com>) id 1daJh6-00012j-88
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 06:37:33 -0400
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:36287)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shantanu16111994@gmail.com>)
	id 1daJh6-00012X-3B
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 06:37:32 -0400
Received: by mail-oi0-x22a.google.com with SMTP id g131so76434397oic.3
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 03:37:31 -0700 (PDT)
MIME-Version: 1.0
From: Shantanu Agarwal <shantanu16111994@gmail.com>
Date: Wed, 26 Jul 2017 16:07:30 +0530
Message-ID: <CADsqsqJ5YNRoqij_O--z+3EicO4WPRzJ5JEpwCAf+H_hnxWSKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Regarding tracing machine instructions through qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello Peter,
Regarding my last mail for tracing qemu.
Actually I need to trace the machine instructions of guest operating
system(in my case it is android - arm architecture). So that I can simulate
the same. This is my project for M.Tech. So I started with the code to play
around and figure out something about qemu, but the code itself is hard
enough that we are not able to get that code. Also tracing with simple
trace provide details which are not exactly what we want. Is there some
link or a particular documentation for finding the actual trace. Also the
discussion on the link, you sent me earlier, to be honest, I didn't get
what you discussed.

For tracing such machine instructions, do I have to make changes to source
code, or simply changing the course of building the qemu from source will
do the trick.
-- 
with regards,
Shantanu Agarwal
Mtech 1st Year
+919958818058
IIT Delhi, New Delhi - 110016
