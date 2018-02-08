Received: from eggs.gnu.org ([2001:4830:134:3::10]:48529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejmE1-0004PU-Rd
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 08:26:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejmE1-0004Tb-3f
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 08:26:53 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f1007bf5-f726-bf87-8f4f-b35ca6f9dee1@amsat.org>
Date: Thu, 8 Feb 2018 10:26:40 -0300
MIME-Version: 1.0
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 00/54] Patch Round-up for stable 2.11.1,
 freeze on 2018-02-12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com

Hi Michael,

On 02/06/2018 04:14 PM, Michael Roth wrote:
> The release is planned for 2017-02-14:
> 
>   https://wiki.qemu.org/Planning/2.11
> 
> Please respond here or CC qemu-stable@nongnu.org on any patches you
> think should be included in the release.
> 
> ----------------------------------------------------------------
> ----------------------------------------------------------------
> Alex Bennée (1):
>       target/sh4: fix TCG leak during gusa sequence

There is also e691e0ed135 "target/sh4: add missing tcg_temp_free() in
_decode_opc()"
