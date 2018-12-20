Received: from eggs.gnu.org ([2001:4830:134:3::10]:50710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gZzyw-0003zq-Af
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 10:11:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gZzyo-00075H-Au
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 10:11:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gZzym-00073V-B9
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 10:11:18 -0500
Date: Thu, 20 Dec 2018 16:11:05 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181220161105.6a7c80b1@Igors-MacBook-Pro.local>
In-Reply-To: <CAFEAcA8-R16eHcPKcYw==PCdA7mwf8+V57aKX=SUdcX1zWqDsQ@mail.gmail.com>
References: <20181218161008.3882-1-mst@redhat.com>
	<CAFEAcA-mzqQ+tt+43LVnruBj9Mgf2q7MaCgV5o2BPz3GJT+i+A@mail.gmail.com>
	<20181220154959.4a598d84@Igors-MacBook-Pro.local>
	<CAFEAcA8-R16eHcPKcYw==PCdA7mwf8+V57aKX=SUdcX1zWqDsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v2 00/30] pci, pc, virtio: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, 20 Dec 2018 14:52:49 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Thu, 20 Dec 2018 at 14:50, Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > On Wed, 19 Dec 2018 19:15:26 +0000
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> > > Hi; I'm afraid I get conflicts in some files which look
> > > too complicated for me to want to try to resolve at this end:
> > > Auto-merging tests/vmgenid-test.c
> > > CONFLICT (content): Merge conflict in tests/vmgenid-test.c
> > > Auto-merging tests/bios-tables-test.c
> > > CONFLICT (content): Merge conflict in tests/bios-tables-test.c
> > > Auto-merging tests/acpi-utils.h
> > > CONFLICT (content): Merge conflict in tests/acpi-utils.h
> > > Auto-merging tests/acpi-utils.c
> > > CONFLICT (content): Merge conflict in tests/acpi-utils.c
> > > Removing include/hw/smbios/ipmi.h
> >
> > I'm working on fixing conflicts due to 29/30 and will include conflicting patch in my acpi tests cleanup on respin
> >
> > Meanwhile could you drop 29/30 and apply the rest of pull request (which applies just fine)?
> 
> I can't apply a partial pull request -- MST will need to
> drop those patches and send a v2.

ok
I'll post fixed  up patch here for MST to pick it up

PS:
/me need to learn how to do pull requests


> 
> thanks
> -- PMM
