Received: from eggs.gnu.org ([2001:4830:134:3::10]:49250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1d41u0-00008z-Q9
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:09:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1d41tw-0007b8-Ex
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:09:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1d41tw-0007aT-8n
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:09:20 -0400
Date: Fri, 28 Apr 2017 14:39:07 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <20170428084906.GB23819@redhat.com>
Message-ID: <alpine.LFD.2.20.1704281438130.29240@wniryva>
References: <20170428084237.23960-1-kraxel@redhat.com>
	<20170428084906.GB23819@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] input: limit kbd queue depth
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, Huawei PSIRT <PSIRT@huawei.com>

  Hello Dan,

+-- On Fri, 28 Apr 2017, Daniel P. Berrange wrote --+
| Ability for a remote network client to crash a host by exhausting
| memory should be considered a security flaw & have a CVE allocated
| for it.

Yes, I'm getting it assigned.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
