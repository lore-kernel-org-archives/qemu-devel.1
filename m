Received: from eggs.gnu.org ([2001:4830:134:3::10]:59527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cOVmv-00061e-E4
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 15:34:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cOVms-0001iu-CQ
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 15:34:29 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:36980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcd@tribudubois.net>) id 1cOVms-0001hq-68
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 15:34:26 -0500
References: <20161224151113.23955-1-jcd@tribudubois.net>
	<606aedd3-2f56-fb89-b547-763baf833ed5@gmail.com>
	<5b3ba089-e218-40ff-3b72-f31ada1e4cfc@tribudubois.net>
	<a6c26a91-696c-db4b-7311-7cfc7ef9ee74@gmail.com>
	<ccab130c-3f65-e4b4-8453-b2fd0f1110ae@tribudubois.net>
	<5f1acd02-018d-0a17-105c-cd42c50a3e91@tribudubois.net>
	<d320496c-42d0-f8ae-71ea-e81073f2cf9d@gmail.com>
	<684d34f1-9107-1ed0-1115-f3034bd899f4@tribudubois.net>
	<a25f717f-28b6-959a-92c3-a7233dcf7fe2@gmail.com>
	<3f17d9af-a43f-82cb-c477-e2036ab7492a@tribudubois.net>
	<11ce9101-b01a-9d6a-4f0e-b459b5f49f0c@gmail.com>
From: Jean-Christophe DUBOIS <jcd@tribudubois.net>
Message-ID: <309100ce-3734-c9df-0130-0485494ec394@tribudubois.net>
Date: Tue, 3 Jan 2017 21:34:20 +0100
MIME-Version: 1.0
In-Reply-To: <11ce9101-b01a-9d6a-4f0e-b459b5f49f0c@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] [M25P80] Make sure not to overrun the
 internal data buffer.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "mar.krzeminski" <mar.krzeminski@gmail.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org

Le 03/01/2017 à 18:08, mar.krzeminski a écrit :
>
>> You may still want to harden the m25p80 code to make sure it doesn't 
>> overrun its internal buffer.
>
> Yeap, for me it is a bug.
> I understand you will not finish this patch, won't you ?:)

I could give it a shot.

JC
