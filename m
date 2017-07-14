Received: from eggs.gnu.org ([2001:4830:134:3::10]:53796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVwVW-0004B0-Dl
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:03:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVwVV-00065j-QH
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:03:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dVwVV-00065Z-K0
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:03:29 -0400
Date: Fri, 14 Jul 2017 11:03:25 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170714110325.67e7d205@gondolin>
In-Reply-To: <1499961789-127874-1-git-send-email-borntraeger@de.ibm.com>
References: <1499961789-127874-1-git-send-email-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/7] s390: remaining patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>

On Thu, 13 Jul 2017 18:03:02 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> here is a bunch of patches that teaches recent HW features
> to the CPU model and kvm code in QEMU. We also add the 
> enhanced suppression on protection facility to the z12 and later
> for the 2.10 machine type.

Looks good from my side.

I assume you'll put out a pull request soon?
