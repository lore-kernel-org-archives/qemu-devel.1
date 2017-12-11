Received: from eggs.gnu.org ([2001:4830:134:3::10]:53434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eOHov-0002Z9-4U
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 01:44:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eOHoq-0005AL-Lz
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 01:44:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eOHoq-00059t-G9
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 01:44:04 -0500
Date: Mon, 11 Dec 2017 14:44:00 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171211064400.GA3350@lemon>
References: <MWHPR02MB24632F9FF42C04523C52E5F6D4370@MWHPR02MB2463.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR02MB24632F9FF42C04523C52E5F6D4370@MWHPR02MB2463.namprd02.prod.outlook.com>
Subject: Re: [Qemu-devel] BIOS and virus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: microsoft gaofei <wangziheng@outlook.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Mon, 12/11 00:46, microsoft gaofei wrote:
> QEMU depended on seabios by default . sudo pacman -S qemu ,sudo apt install qemu ,,that will auto-install seabios . So seabios is installed in my system , NOT a single file .
> 
> https://thehackernews.com/2011/09/bios-based-virus-discovered-by-chinese.html
> What if I run BMW in QEMU ? Will it destroy seabios then affect other virtual
> machines ?
> 
> https://www.coreboot.org/QEMU     Do I have to prepare a single file to avoid
> the virus ? Since seabios is auto-installed by a distribution's package
> manager , NOT a single file .

The article says the bug infects Award BIOS only so I don't think there is a
problem with Seabios.

Fam
