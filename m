Received: from eggs.gnu.org ([2001:4830:134:3::10]:46462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eg1KR-0004ei-0L
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 23:46:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eg1KN-0005AG-TW
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 23:45:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eg1KN-00059b-Mx
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 23:45:55 -0500
Date: Mon, 29 Jan 2018 06:45:52 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180129064446-mutt-send-email-mst@kernel.org>
References: <1516747387-31760-1-git-send-email-mst@redhat.com>
	<1516747387-31760-2-git-send-email-mst@redhat.com>
	<20180124094621.46ff2f43@bahia.lan>
	<20180124100500.1f9bf54a@bahia.lan>
	<d0698024-65ae-fb6b-397d-cccdc1fb36f4@redhat.com>
	<20180124103402.6ef42523@bahia.lan>
	<20180124190820-mutt-send-email-mst@kernel.org>
	<CAA2ifQybqzCYC48fjzT9mztn=3iTS+3uO0DUF8bxAF5jt3u-Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA2ifQybqzCYC48fjzT9mztn=3iTS+3uO0DUF8bxAF5jt3u-Vg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 1/1] kvm-all: Partially reverts 4fe6d78b2e
 to remove the cleanup call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gal Hammer <ghammer@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Anton Blanchard <anton@samba.org>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

On Sun, Jan 28, 2018 at 04:07:27PM +0200, Gal Hammer wrote:
> Hi,
> 
> Sorry for a bad patch and the problems it may have caused.

Not at all, these things happen.  Do you have short term plans to work
on a new version?
