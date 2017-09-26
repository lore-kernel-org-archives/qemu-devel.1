Received: from eggs.gnu.org ([2001:4830:134:3::10]:33051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwivc-0003Cp-4y
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 02:01:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwivX-0005ZC-Bi
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 02:01:08 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
References: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
	<CAFEAcA9GtLniZNyO7Uv=vL9HiSBGjvWRYdR-Zi1E+W4N9qiB6A@mail.gmail.com>
	<55782343-4bb4-d5ed-2c5d-4dd0fc5764dd@tls.msk.ru>
Message-ID: <49eb0a94-5ca0-fb0d-e2b5-3bc965d3a5be@msgid.tls.msk.ru>
Date: Tue, 26 Sep 2017 09:00:59 +0300
MIME-Version: 1.0
In-Reply-To: <55782343-4bb4-d5ed-2c5d-4dd0fc5764dd@tls.msk.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/31] Trivial patches for 2017-09-25
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Eduardo Otubo <otubo@redhat.com>

26.09.2017 08:57, Michael Tokarev wrote:
..
> Reverting this patch makes it run again. Cc'ing Eduardo.
> 
> I'll remove this patch, patch "hw/isa/pc87312: Mark the device with
> user_creatable = false" (will be replaced with a better variant),

Actually "dma/i82374: avoid double creation of i82374 device" :)

(Also Cc'ing Eduardo :) )

/mjt
