Received: from eggs.gnu.org ([2001:4830:134:3::10]:52238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1daziM-0002PB-5e
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 03:29:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1daziJ-0003tU-2a
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 03:29:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1daziI-0003st-Td
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 03:29:35 -0400
Date: Fri, 28 Jul 2017 09:29:25 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170728092925.51a4626f@gondolin>
In-Reply-To: <20170728072526.GD15504@bjsdjshi@linux.vnet.ibm.com>
References: <20170727015418.85407-1-bjsdjshi@linux.vnet.ibm.com>
	<20170727015418.85407-3-bjsdjshi@linux.vnet.ibm.com>
	<20170727132259.7102a715@gondolin>
	<20170728072526.GD15504@bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] s390x/css: generate solicited crw for
 rchp completion signaling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com

On Fri, 28 Jul 2017 15:25:26 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> So, I only need to s/s/solicited for the new version of this one?

Yes, that would be fine.
