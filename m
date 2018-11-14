Received: from eggs.gnu.org ([2001:4830:134:3::10]:33136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <raistlin.df@gmail.com>) id 1gMsql-00031c-Ue
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 05:56:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <raistlin.df@gmail.com>) id 1gMsqi-0007wY-Qn
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 05:56:47 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:33472)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <raistlin.df@gmail.com>)
	id 1gMsqf-0007t3-HL
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 05:56:42 -0500
Received: by mail-wm1-f53.google.com with SMTP id f19-v6so13258837wmb.0
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 02:56:33 -0800 (PST)
Received: from [127.0.0.1] (96-210-66-80.hosts.abilene.it. [80.66.210.96])
	by smtp.gmail.com with ESMTPSA id
	6-v6sm15540885wra.35.2018.11.14.02.56.30 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 14 Nov 2018 02:56:30 -0800 (PST)
From: Dario Faggioli <dfaggioli@suse.com>
Date: Wed, 14 Nov 2018 11:56:47 +0100
Message-ID: <154219299016.19470.9372139354280787961.stgit@wayrath>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH 0/3] Series short description
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following series implements...

---

Dario Faggioli (3):
      i386: add properties for customizing L2 and L3 caches size
      i386: custom cache size in CPUID2 and CPUID4 descriptors
      i386: custom cache size in AMD's CPUID descriptors too


 0 files changed

--
Signature
