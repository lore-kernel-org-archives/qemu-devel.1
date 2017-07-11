Received: from eggs.gnu.org ([2001:4830:134:3::10]:34505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dUzno-0000N1-JB
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:22:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dUznj-0000Ic-NU
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:22:28 -0400
References: <CAFEAcA_HPtBhES_9L1KZzJTDJRpxD=0Ux-OyC3BV2UDNKZg2hg@mail.gmail.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <40961524-561e-aa31-b043-7b8ae9203b7c@suse.de>
Date: Tue, 11 Jul 2017 20:22:19 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_HPtBhES_9L1KZzJTDJRpxD=0Ux-OyC3BV2UDNKZg2hg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] should we update QEMU's u-boot submodule and
 binary?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>



On 11.07.17 19:43, Peter Maydell wrote:
> Hi; I just noticed that our u-boot submodule is still stuck on
> a commit from 2014 when it was first added to QEMU. Should we
> move this forward to some more recent u-boot release?
> 
> I think we only use this for our ppc e500 rom...

It probably makes sense to update the e500 rom and bump the submodule to 
the latest U-Boot release along the way, yes.


U-Boot 2017.07 just got released, so now is quite a good point in time 
to do so.


Alex
