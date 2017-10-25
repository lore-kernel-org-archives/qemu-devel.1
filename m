Received: from eggs.gnu.org ([2001:4830:134:3::10]:58061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e7Lm6-00027n-Tm
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 09:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e7Lm1-0006PE-Dd
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 09:31:14 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171024122045.30072-1-f4bug@amsat.org>
	<1508869162.4025.1.camel@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <01856102-8692-2fcb-9c69-000a4236b2ad@amsat.org>
Date: Wed, 25 Oct 2017 10:30:14 -0300
MIME-Version: 1.0
In-Reply-To: <1508869162.4025.1.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 0/4] tpm: add stubs to fix compiling
 with --disable-tpm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: amarnath.valluri@intel.com
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, "Richard W . M . Jones" <rjones@redhat.com>, Peter Xu <peterx@redhat.com>, qemu-trivial@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Hi Amarnath,

On 10/24/2017 03:19 PM, Amarnath Valluri wrote:
> On Tue, 2017-10-24 at 09:20 -0300, Philippe Mathieu-Daudé wrote:
>> This fixes building with --disable-tpm as reported by Zoltan:
>>   http://lists.nongnu.org/archive/html/qemu-devel/2017-10/msg05369.html
[...]
> +1, Nice cleanup in my opinion, now it looks much cleaner.

Thanks, however I'm not sure what a +1 means, is it equivalent to an
Acked-by or a Reviewed-by tag? If so it would be better to write them
explicitly.

Regards,

Phil.
