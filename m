Received: from eggs.gnu.org ([2001:4830:134:3::10]:57331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1chp7Z-0004ut-U8
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 22:03:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1chp7Y-0003s6-Q3
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 22:03:37 -0500
MIME-Version: 1.0
In-Reply-To: <8EE0E791-D80F-416B-B145-5D423310B65C@gmail.com>
References: <mailman.54661.1487925109.22739.qemu-devel@nongnu.org>
	<D18A2230-B3C1-46E9-A43E-291E5F672CBB@gmail.com>
	<87efynl9k1.fsf@linaro.org>
	<8EE0E791-D80F-416B-B145-5D423310B65C@gmail.com>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Sat, 25 Feb 2017 22:03:02 -0500
Message-ID: <CAJhHMCDZY5JeifFgVn2MRAz1XvS=8C8cg7padnQWPGd0sepWtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v14 00/24] MTTCG Base enabling patches with
 ARM enablement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "list@suse.de:PowerPC list:PowerPC" <qemu-ppc@nongnu.org>, qemu-devel qemu-devel <qemu-devel@nongnu.org>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

On Sat, Feb 25, 2017 at 8:46 PM, Programmingkid
<programmingkidx@gmail.com> wrote:
>
>
> With the i386 target, I did see host CPU usage go up to 120%. That was nice
> to see. Windows XP and Windows 2000 would not boot to the desktop for some
> reason.

For windows XP, you need the patch here:
http://patchwork.ozlabs.org/patch/731915/

Let me know if that patch helps.

Thanks,
--
Pranith
