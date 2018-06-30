Received: from eggs.gnu.org ([2001:4830:134:3::10]:59543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fZJBk-0002NH-Ar
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 12:57:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fZJBf-0006f1-99
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 12:57:32 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180621171257.14897-1-f4bug@amsat.org>
	<20180621171257.14897-6-f4bug@amsat.org>
	<20180622062225.ay4bubgshxjj3uey@sirius.home.kraxel.org>
	<3a5e52f6-3b65-5ce8-f5d2-48b76e3e4f21@amsat.org>
	<20180622123149.qxirhe6uajzkc22s@sirius.home.kraxel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f6854a8f-19bb-befc-42b4-bb6820813e2c@amsat.org>
Date: Sat, 30 Jun 2018 13:57:22 -0300
MIME-Version: 1.0
In-Reply-To: <20180622123149.qxirhe6uajzkc22s@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/11] hw/display/cirrus: Convert printf()
 calls to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

Can this patch go via the Trivial tree?

On 06/22/2018 09:31 AM, Gerd Hoffmann wrote:
>>> Indention looks weird.
>>
>> Actually this is the code around that is weirdly intended, a mix of
>> <tab> and <spaces>.
> 
> Ok.
> 
>> Do you prefer a previous indent cleanup patch or can I add your Acked-by
>> tag?
> 
> Leave as is.  Breaking "git blame" with a whitespace cleanup is not
> useful indeed.
> 
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> cheers,
>   Gerd
