Received: from eggs.gnu.org ([2001:4830:134:3::10]:59915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brendanjsimon@gmail.com>) id 1eH4dv-0007Vt-Nf
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 04:15:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brendanjsimon@gmail.com>) id 1eH4ds-0004kK-KG
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 04:14:59 -0500
Received: from mail-it0-x22d.google.com ([2607:f8b0:4001:c0b::22d]:36523)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brendanjsimon@gmail.com>)
	id 1eH4ds-0004k6-Eq
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 04:14:56 -0500
Received: by mail-it0-x22d.google.com with SMTP id 187so1190630iti.1
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 01:14:56 -0800 (PST)
Received: from MacBook-Pro.local (CPE-101-182-8-127.lnse1.woo.bigpond.net.au.
	[101.182.8.127]) by smtp.googlemail.com with ESMTPSA id
	j193sm458519ita.9.2017.11.21.01.14.52 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 Nov 2017 01:14:53 -0800 (PST)
Sender: Brendan Simon <brendanjsimon@gmail.com>
Reply-To: brendan.simon@etrix.com.au
From: "Brendan Simon (eTRIX)" <brendan.simon@etrix.com.au>
Message-ID: <96af8d77-c40a-01ea-a91e-0de5d0a48b04@etrix.com.au>
Date: Tue, 21 Nov 2017 20:14:49 +1100
MIME-Version: 1.0
Content-Language: en-AU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] Apple hyphervisor.framework availability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

Hi QEMU devs,

Just wondering when the accelerator for Apple's hypervisor.framework
(hvf) will hit the git repos to build and try out?

I get the impression that patches have been submitted, but I can't see
anything in the repos.  Is there a special branch or fork where these
patches reside?

Thanks,
Brendan.
