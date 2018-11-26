Received: from eggs.gnu.org ([2001:4830:134:3::10]:52083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gRGNS-0006j8-Ho
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 07:52:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gRGNO-0007wl-Jb
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 07:52:38 -0500
Date: Mon, 26 Nov 2018 13:52:30 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20181126125230.GO1148@toto>
References: <20181123135450.24829-1-edgar.iglesias@gmail.com>
	<20181123135450.24829-2-edgar.iglesias@gmail.com>
	<75bcddbc-da2d-aeb3-71d3-52b635520d2a@redhat.com>
	<20181123165945.GM1148@toto>
	<CAFEAcA8vWT5sayyBzbU7S8BwA06Kj=G1izioufjHFJdsEkyq4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8vWT5sayyBzbU7S8BwA06Kj=G1izioufjHFJdsEkyq4g@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v1 1/1] net: cadence_gem: Remove incorrect
 assert()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, mbilal <muhammad_bilal@mentor.com>, KONRAD Frederic <frederic.konrad@adacore.com>, Alistair Francis <alistair@alistair23.me>, Francisco Iglesias <frasse.iglesias@gmail.com>, figlesia@xilinx.com, Stefano Stabellini <sstabellini@kernel.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>

On Fri, Nov 23, 2018 at 05:09:35PM +0000, Peter Maydell wrote:
> On Fri, 23 Nov 2018 at 16:59, Edgar E. Iglesias
> <edgar.iglesias@gmail.com> wrote:
> > Not sure if it's too late to even get the removal of the assert into this release? Peter?
> 
> If you're happy that removing the assert is the correct fix,
> yes, this could go in before rc3 next week.


Yes, I think removing the assert is a suitable fix for the release.

Thanks!
Edgar
