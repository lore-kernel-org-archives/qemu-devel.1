Received: from eggs.gnu.org ([2001:4830:134:3::10]:59096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dYR5l-00072V-MS
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 02:07:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dYR5k-00071z-Vh
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 02:07:13 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <150061294855.99.3974027380695554466@5d477a5b5989>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5282c2cc-0924-6920-cec5-b90dcfb2c02b@amsat.org>
Date: Fri, 21 Jul 2017 03:06:59 -0300
MIME-Version: 1.0
In-Reply-To: <150061294855.99.3974027380695554466@5d477a5b5989>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] Revert "elf-loader: warn about
 invalid endianness"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: famz@redhat.com, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Hi Jason, Michael,

On 07/21/2017 01:55 AM, no-reply@patchew.org wrote:
> This series failed automatic build test. Please find the testing commands and
> their output below. If you have docker installed, you can probably reproduce it
> locally.
[...]
> GTester: last random seed: R02Sd7d1d0ad279b9a1e69acb248301b1ab6
> Vhost user backend fails to broadcast fake RARP
> make: *** [check-tests/test-replication] Error 1
Any idea about this error?
