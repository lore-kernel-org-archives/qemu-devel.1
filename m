Received: from eggs.gnu.org ([2001:4830:134:3::10]:52966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dcRST-0002kF-I2
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 03:19:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dcRSQ-0007pL-Ba
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 03:19:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dcRSQ-0007oP-5u
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 03:19:10 -0400
Date: Tue, 1 Aug 2017 09:19:04 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170801091904.3ae59ad2@gondolin>
In-Reply-To: <20170801021231.GE12259@bjsdjshi@linux.vnet.ibm.com>
References: <20170727015418.85407-1-bjsdjshi@linux.vnet.ibm.com>
	<20170727114603.77b801e2@gondolin>
	<20170728092108.GE15504@bjsdjshi@linux.vnet.ibm.com>
	<20170728135301.0b510793@gondolin>
	<20170728155048.GB5874@bjsdjshi@linux.vnet.ibm.com>
	<20170731105447.70428667@gondolin>
	<20170801021231.GE12259@bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] Channel Path realted CRW generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, rth@twiddle.net

On Tue, 1 Aug 2017 10:12:31 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> Since I only want to expose the minimum information that the guest needs
> to work without serious problem. I think I can also deffer these stuff
> until we have the good chp modelling.

Yes, that's probably the best way to proceed.
