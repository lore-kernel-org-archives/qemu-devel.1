Received: from eggs.gnu.org ([2001:4830:134:3::10]:58162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cQdSd-0007Iv-Oy
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 12:10:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cQdSZ-0000Cv-H9
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 12:10:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cQdSZ-0000CQ-B3
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 12:10:15 -0500
Date: Mon, 9 Jan 2017 18:10:10 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170109181010.7f0def81@nial.brq.redhat.com>
In-Reply-To: <20170103123736.28058223@nial.brq.redhat.com>
References: <4D4A9683-A287-48CD-9D76-41850225B34C@binghamton.edu>
	<20170103123736.28058223@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QEMU online/offline cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ozgur O Kilic <okilic1@binghamton.edu>
Cc: Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>

On Tue, 3 Jan 2017 12:37:36 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

[...]
> Wiki page http://wiki.qemu.org/Features/CPUHotplug is rather outdated,
> I'll update it to reflect currently implemented hotplug interfaces/targets.

David,

I've updated above CPUHotplug wiki page to match current state of QEMU.
Could you take a look at it and maybe update from SPAPR perspective.

PS:
Feel free to fix whatever if you find a better wording/mistake.
