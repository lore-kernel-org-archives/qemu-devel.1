Received: from eggs.gnu.org ([2001:4830:134:3::10]:33972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gX9OF-00084O-Di
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 13:37:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gX9OC-0002S0-4v
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 13:37:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gX9OB-0002Rl-Vh
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 13:37:44 -0500
Date: Thu, 13 Dec 2018 00:07:38 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <20181212180804.GF5747@lap1>
Message-ID: <nycvar.YSQ.7.76.1812130004080.1552@xnncv>
References: <20181211132642.3027-1-ppandit@redhat.com>
	<20181211132642.3027-5-ppandit@redhat.com>
	<20181211164742.GA2923@lap1> <20181211172244.GD2923@lap1>
	<nycvar.YSQ.7.76.1812120137210.7578@xnncv>
	<nycvar.YSQ.7.76.1812121253200.10904@xnncv>
	<20181212180804.GF5747@lap1>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 4/5] pvrdma: release ring object in case of
 an error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Saar Amar <saaramar5@gmail.com>, Li Qiang <liq3ea@163.com>

+-- On Wed, 12 Dec 2018, Yuval Shaia wrote --+
| Can you try master?
| I just did a rebase on top of master and had no conflicts.

  Yes, I tried with master first, got the same errors, that's when I tried 
earlier versions.

Preparing patch-set v2 with the suggested updates.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
