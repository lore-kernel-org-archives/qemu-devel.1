Received: from eggs.gnu.org ([2001:4830:134:3::10]:55941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e1x3N-0001sK-PI
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e1x3I-0006gj-0o
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:06:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e1x3H-0006gU-Qs
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:06:39 -0400
Date: Tue, 10 Oct 2017 13:03:57 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171010160357.GG3246@localhost.localdomain>
References: <20171005203638.19255-1-ehabkost@redhat.com>
	<CAFEAcA-jBzTXWNrRCB8GXm2FcZdT3pPFZiGT6O6Oc8qpfSK_jA@mail.gmail.com>
	<20171006152751.GR4015@localhost.localdomain>
	<CAFEAcA94pKm22fX1kCr72-SsM06Z2AMUZ65a7zJ_UPrarkBg1w@mail.gmail.com>
	<4479e30f-801d-0d8e-712d-06f2dd987528@cn.fujitsu.com>
	<20171010125231.GD4015@localhost.localdomain>
	<CAFEAcA_M-6yb1Vx0dT77zg8wUO+vNzawTNnubmd=OO_CB6t9vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_M-6yb1Vx0dT77zg8wUO+vNzawTNnubmd=OO_CB6t9vg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/9] x86 and machine queue, 2017-10-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, Oct 10, 2017 at 01:56:55PM +0100, Peter Maydell wrote:
> On 10 October 2017 at 13:52, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > This shouldn't happen if CONFIG_IASL is not defined.  Did you run
> > configure again after removing iasl?
> 
> I've neither added nor removed iasl from the build systems
> in question. Pull request tests just apply the pull and
> run make/make check.

I understand.  The question was about the test failure reported
by Dou Liyang.

-- 
Eduardo
