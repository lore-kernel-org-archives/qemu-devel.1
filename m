Received: from eggs.gnu.org ([2001:4830:134:3::10]:54655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1drN6F-0002hs-0c
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1drN6E-0005cz-7m
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:41:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1drN6E-0005cm-1y
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:41:58 -0400
Date: Mon, 11 Sep 2017 13:41:54 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170911134154.29848060@nial.brq.redhat.com>
In-Reply-To: <150481287759.22567.13847737619709716347.malone@gac.canonical.com>
References: <150480187483.29281.9921794433489304819.malonedeb@chaenomeles.canonical.com>
	<150481287759.22567.13847737619709716347.malone@gac.canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Bug 1715700] Re: Windows 7 guest won't boot on
 qemu 2.10 (works on 2.9)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksei Kovura <alex3kov@zoho.com>
Cc: Bug 1715700 <1715700@bugs.launchpad.net>, qemu-devel@nongnu.org

On Thu, 07 Sep 2017 19:34:37 -0000
Aleksei Kovura <alex3kov@zoho.com> wrote:

> Compiled latest OVMF from git (ea21f1d), used it in "-bios" line - same
> result. What else can I try?
Bisecting 2.9 -> 2.10 might point out offending commit
