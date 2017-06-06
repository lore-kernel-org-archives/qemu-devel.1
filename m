Received: from eggs.gnu.org ([2001:4830:134:3::10]:36068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIFcT-0006Wj-E6
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 10:38:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIFcS-0003hO-4u
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 10:38:05 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:35598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dIFcR-0003gp-UV
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 10:38:04 -0400
Received: by mail-wm0-x22a.google.com with SMTP id x70so38671004wme.0
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 07:38:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170606025135.2685-1-david@gibson.dropbear.id.au>
References: <20170606025135.2685-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Jun 2017 15:37:42 +0100
Message-ID: <CAFEAcA8ziQyNHz3REERYeuQ4DQB90Fd14Mxaok5pfK0k3n_h2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/17] ppc-for-2.10 queue 20170606
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 6 June 2017 at 03:51, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit 199e19ee538eb61fd08b1c1ee5aa838ebdcc968e:
>
>   Merge remote-tracking branch 'remotes/mjt/tags/trivial-patches-fetch' into staging (2017-06-05 15:28:12 +0100)
>
> are available in the git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.10-20170606
>
> for you to fetch changes up to 91dcb1ffa67cfa41a13dcc89dd44e2310b5773b0:
>
>   spapr: Remove some non-useful properties on DRC objects (2017-06-06 09:24:25 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2017-06-06
>
> Accumulated patches for ppc targets and the pseries machine type.
>
> The big thing in this batch is a start on a substantial cleanup of the
> pseries hotplug mechanisms, which were pretty confusing.  For now
> these shouldn't cause substantial behavioural changes, but I am hoping
> these lead to clearer code and eventually to fixes for the bugs we
> have in hotplug handling, particularly when hotplug and migration are
> combined.
>
> The remaining patches are mostly bugfixes.
>

Applied, thanks.

-- PMM
