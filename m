Received: from eggs.gnu.org ([2001:4830:134:3::10]:52842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1evPIE-0002LN-Fv
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:23:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1evPIB-0000Hb-Ag
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:23:18 -0400
References: <1518893216-9983-1-git-send-email-eric.auger@redhat.com>
	<CAFEAcA9KzitEO21Rgh8Azip+gVJjyobzNbk8sHuQf-ngg+Jjxg@mail.gmail.com>
	<74aa2e5e-ed1b-3cf8-8ddc-41f7ef90ad7b@redhat.com>
	<CAFEAcA-Mb_o88ieynaY8k6xehTyAoC13Dkf0QUUyOGmEjRd7XA@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <20cc43e6-47b9-c7e7-09bb-21d170aab182@redhat.com>
Date: Mon, 12 Mar 2018 16:22:54 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-Mb_o88ieynaY8k6xehTyAoC13Dkf0QUUyOGmEjRd7XA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 00/14] ARM SMMUv3 Emulation Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Tomasz Nowicki <tn@semihalf.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Christoffer Dall <christoffer.dall@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, linuc.decode@gmail.com, Bharat Bhushan <bharat.bhushan@nxp.com>, Prem Mallappa <prem.mallappa@gmail.com>, Eric Auger <eric.auger.pro@gmail.com>

Hi Peter,

On 12/03/18 13:58, Peter Maydell wrote:
> On 28 February 2018 at 08:44, Auger Eric <eric.auger@redhat.com> wrote:
>> On 27/02/18 20:02, Peter Maydell wrote:
>>> On 17 February 2018 at 18:46, Eric Auger <eric.auger@redhat.com> wrote:
>>>> This series implements the emulation code for ARM SMMUv3.
> 
>>> What state is this series in now? Is it "seems ready to
>>> go, needs review"? Are you hoping it might get in for 2.12,
>>> or targeting 2.13 ?
> 
>> Yes I think it is in a decent state and I would be happy to get some new
>> reviews, for a tentative pull in 2.12. In any case I will be reactive on
>> any comment in that prospect.
> 
> Hi, Eric. I've now gone through the patchset and reviewed it. Sorry
> I didn't manage to get to this in time to be able to put it into 2.12,
> but there weren't any major or structural issues, so we should be
> able to get this into the tree early in the 2.13 dev cycle.

No worries. I am already really grateful to you for the time you spent
on this comprehensive review.

I have taken into account most of your comments already. I will run some
more tests and post v10 this week then.

Thanks

Eric
> 
> thanks
> -- PMM
> 
