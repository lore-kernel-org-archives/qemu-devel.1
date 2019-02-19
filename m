Received: from eggs.gnu.org ([209.51.188.92]:52308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gw6dw-0006jy-BV
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:45:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gw6dv-0000bg-8V
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:45:08 -0500
Received: from mail-eopbgr810134.outbound.protection.outlook.com
	([40.107.81.134]:39264
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aaron@os.amperecomputing.com>)
	id 1gw6du-0000ai-RL
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:45:07 -0500
From: Aaron Lindsay OS <aaron@os.amperecomputing.com>
Date: Tue, 19 Feb 2019 14:45:03 +0000
Message-ID: <20190219144509.GB22806@quinoa.localdomain>
References: <20190128181047.20781-1-peter.maydell@linaro.org>
	<20190128181047.20781-10-peter.maydell@linaro.org>
	<CAFEAcA8tinUgkBxmUe0-WNcaYStu0=6HsXwejQdOZ=L8ZSygXA@mail.gmail.com>
	<20190219142345.GA22806@quinoa.localdomain>
	<CAFEAcA8UeSUn4+NtbCVy_6UAbspJnzr6_tAe+V=hnywDRgfd4g@mail.gmail.com>
In-Reply-To: <CAFEAcA8UeSUn4+NtbCVy_6UAbspJnzr6_tAe+V=hnywDRgfd4g@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B4D4BB7AD63EDA4C85F3725587CC4EA2@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PULL 09/26] target/arm: Don't clear supported PMU
 events when initializing PMCEID1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Feb 19 14:33, Peter Maydell wrote:
> On Tue, 19 Feb 2019 at 14:23, Aaron Lindsay OS
> <aaron@os.amperecomputing.com> wrote:
> > I registered for a Coverity account and am awaiting approval for adding
> > me to the QEMU project so I can test this myself (let me know if this
> > isn't the right way to go about this).
> >
> > Would you prefer I wait until I'm able to test that this is resolved
> > myself, or just submit a patch and have you test it?
>=20
> You should just submit a patch. Coverity runs only on the
> git master, so until your patch is in master it won't get
> retested. Having an account with the coverity scan website
> is useful mostly for looking at reports in more detail,
> or for those enthusiastic to actively go triaging and
> fixing things.

Ah, okay. I'll send a patch out shortly.

-Aaron
