Received: from eggs.gnu.org ([2001:4830:134:3::10]:46658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQzLg-0003uk-4N
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 14:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQzLf-0005SY-Ap
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 14:09:24 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180607180641.874-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <db2a6b88-e7d1-fd0b-b790-76436dff2f35@amsat.org>
Date: Thu, 7 Jun 2018 15:09:14 -0300
MIME-Version: 1.0
In-Reply-To: <20180607180641.874-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 0/7] sdcard: cleanup the SD_SPEC version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paul Brook <paul@codesourcery.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>

On 06/07/2018 03:06 PM, Philippe Mathieu-Daudé wrote:
> Since v2:
> - heavy documentation improvements
> - squashed previous 3+4 "add spec_version property default to v2" for atomicity
> - SSI/SD patch downgraded to RFC
> - added Alistair R-b tags

Patches missing review: #1 and #4 (#6 being RFC waits for comments).
