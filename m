Received: from eggs.gnu.org ([2001:4830:134:3::10]:60287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6p2I-0005Sv-2L
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 22:33:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6p2H-0006EY-9K
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 22:33:46 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171023213359.23025-1-f4bug@amsat.org>
	<20171023213359.23025-4-f4bug@amsat.org>
	<20171023213732.GX18285@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4a8ab2c3-0576-9c8e-d6c7-8353337fdbe1@amsat.org>
Date: Mon, 23 Oct 2017 23:33:31 -0300
MIME-Version: 1.0
In-Reply-To: <20171023213732.GX18285@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] vl: remove unnecessary #ifdef
 CONFIG_TPM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>

Hi Richard,

On 10/23/2017 06:37 PM, Richard W.M. Jones wrote:
> The series fixes the build for me, thanks :-)

Good, does this mean I can add your Tested-by: tag?

Regards,

Phil.
