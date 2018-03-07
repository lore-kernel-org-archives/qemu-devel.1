Received: from eggs.gnu.org ([2001:4830:134:3::10]:38514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1etTS6-0003vA-Ny
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 02:25:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1etTS3-0002WY-I2
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 02:25:30 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38622 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1etTS3-0002WO-DJ
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 02:25:27 -0500
Date: Wed, 7 Mar 2018 12:55:10 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <1513877118-3149-4-git-send-email-jack.schwartz@oracle.com>
Message-ID: <nycvar.YSQ.7.76.1803071252000.20163@wniryva>
References: <1513877118-3149-1-git-send-email-jack.schwartz@oracle.com>
	<1513877118-3149-4-git-send-email-jack.schwartz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH QEMU v1 3/4] multiboot: Use header names
 when displaying fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jack Schwartz <jack.schwartz@oracle.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, konrad.wilk@oracle.com, daniel.kiper@oracle.com, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net

+-- On Thu, 21 Dec 2017, Jack Schwartz wrote --+
| Refer to field names when displaying fields in printf and debug statements.

I wonder if it's required; Having variable names is helpful while going 
through code.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
