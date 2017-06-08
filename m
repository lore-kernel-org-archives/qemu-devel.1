Received: from eggs.gnu.org ([2001:4830:134:3::10]:36641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mwoodpatrick@gmail.com>) id 1dIyXZ-0002WZ-9k
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mwoodpatrick@gmail.com>) id 1dIyXU-0002Jx-CM
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:36:01 -0400
Received: from mail-pg0-x234.google.com ([2607:f8b0:400e:c05::234]:35440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mwoodpatrick@gmail.com>)
	id 1dIyXU-0002Jg-09
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:35:56 -0400
Received: by mail-pg0-x234.google.com with SMTP id k71so16709743pgd.2
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 07:35:55 -0700 (PDT)
Received: from MarksDesktop (searspoint.nvidia.com. [216.228.112.21])
	by smtp.gmail.com with ESMTPSA id v3sm11584811pfi.3.2017.06.08.07.35.53
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 08 Jun 2017 07:35:53 -0700 (PDT)
From: <mwoodpatrick@gmail.com>
References: <034d01d2d94d$9d6be9d0$d843bd70$@gmail.com>
	<029301d2e062$601f0c30$205d2490$@gmail.com>
In-Reply-To: <029301d2e062$601f0c30$205d2490$@gmail.com>
Date: Thu, 8 Jun 2017 07:35:52 -0700
Message-ID: <029401d2e064$87f5ccb0$97e16610$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
Subject: [Qemu-devel] FW: Are there any qemu emulated SR-IOV devices?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I wanted to play around with SR-IOV using qemu and was wondering if there
are any qemu emulated SR-IOV devices I could experiment with?

If not I plan on creating one and would appreciate any pointers to documents
describing how to add an emulated device that supports more than 8 functions
and has ARI enabled

Regards

Mark
