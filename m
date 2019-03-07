Received: from eggs.gnu.org ([209.51.188.92]:53698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1w53-0000LK-6T
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:41:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1w52-0006Zu-Kc
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:41:13 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36863)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h1w52-0006Yw-Dh
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:41:12 -0500
Received: by mail-wm1-f66.google.com with SMTP id j125so9956880wmj.1
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 08:41:12 -0800 (PST)
References: <20190307145839.13128-1-philmd@redhat.com>
	<20190307162425.GK5786@linux.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <dd8f2672-5e71-ab5f-0be2-ec125e1ad1bc@redhat.com>
Date: Thu, 7 Mar 2019 17:41:09 +0100
MIME-Version: 1.0
In-Reply-To: <20190307162425.GK5786@linux.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 0/4] tests: Allow use of Ports bash and
 GNU sed extensions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kamil Rytarowski <n54@gmx.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Brad Smith <brad@comstyle.com>

On 3/7/19 5:24 PM, Kevin Wolf wrote:
> Am 07.03.2019 um 15:58 hat Philippe Mathieu-Daudé geschrieben:
>> This series contains few script cleanups which help to
>> run tests on OpenBSD.
>> Note, this is a split of the previous series, here restricted
>> to tests/.
> 
> Thanks, applied to the block branch.

Thanks Kevin!

Phil.
