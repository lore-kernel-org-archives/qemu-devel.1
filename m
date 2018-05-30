Received: from eggs.gnu.org ([2001:4830:134:3::10]:35563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1fNuq8-0004Nn-7A
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:44:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1fNuq7-0002a5-JP
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:44:08 -0400
Message-ID: <5B0E4813.7030403@huawei.com>
Date: Wed, 30 May 2018 14:43:31 +0800
From: Shannon Zhao <zhaoshenglong@huawei.com>
MIME-Version: 1.0
References: <1527563283-13148-1-git-send-email-zhaoshenglong@huawei.com>
	<CAFEAcA-LoTOnTnSYBpzuyUDFZBsVBaB2qjvzAP_94rou8ob6Tg@mail.gmail.com>
	<65E224A1-C972-4C38-BD6E-41C59191D999@163.com>
	<383b0c0b-4406-869c-5493-df2f48896113@redhat.com>
	<5B0DFB0C.3000002@huawei.com>
	<81226dc7-4b0a-bd1b-6910-0b9a94b0128f@redhat.com>
In-Reply-To: <81226dc7-4b0a-bd1b-6910-0b9a94b0128f@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] ARM: ACPI: Fix use-after-free due to
 memory realloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi Eric,

On 2018/5/30 14:38, Auger Eric wrote:
> I checked against the v1 in my branch thinking you did not change
> anything besides the comment (your log history?).
Sorry about this, I'll add some words in commit message.

Thanks,
-- 
Shannon
