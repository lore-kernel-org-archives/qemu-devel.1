Received: from eggs.gnu.org ([2001:4830:134:3::10]:41827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cr62Z-0000qC-KS
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 12:56:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cr62Z-0004YM-0c
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 12:56:47 -0400
MIME-Version: 1.0
In-Reply-To: <C94A741879221447B4FC9B607EB4FFCD79EA34F4@DGGEMA504-MBX.china.huawei.com>
References: <1459777195-7907-1-git-send-email-vijayak@caviumnetworks.com>
	<1459777195-7907-3-git-send-email-vijayak@caviumnetworks.com>
	<CAFEAcA_755uEOZoGj0SCtmT-5PyLMntkK3wZeuHvZ_kPG9A1aQ@mail.gmail.com>
	<5703D7EE.2000005@redhat.com>
	<CAFEAcA8G_-jQOtnVag2Ef++RbfbEJ-XzNnyYM=o9Sh8c6ohecA@mail.gmail.com>
	<C94A741879221447B4FC9B607EB4FFCD79EA34F4@DGGEMA504-MBX.china.huawei.com>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Thu, 23 Mar 2017 12:56:12 -0400
Message-ID: <CAJhHMCDDu_kEJichH=60N=np+ZKbU1e9bWK-pP9Z-9=Fn4w1_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] about armv8's prefetch decode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wangjintang <wangjintang@huawei.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Shlomo Pongratz (A)" <shlomo.pongratz@huawei.com>, qemu-arm <qemu-arm@nongnu.org>, "Ori Chalak (A)" <Ori.Chalak@huawei.com>, qemu-devel <qemu-devel@nongnu.org>

Hi Jed,

On Mon, Mar 20, 2017 at 2:35 AM, Wangjintang <wangjintang@huawei.com> wrote=
:
> Hi,
>
>         We see that armv8's prefetch instruction decode have been skipped=
 in qemu. For some user, they need prefetch instruction, for example, they =
use qemu to generate the instruction trace. We want to merge this patch to =
community, it's ok or not?  Thanks.
>

Your patch seems to be missing. Can you retry with the content of the
patch pasted in the email?

Thanks,
--
Pranith
