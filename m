Received: from eggs.gnu.org ([2001:4830:134:3::10]:36522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1da127-0001uG-Dr
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:42:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1da126-0000yF-FU
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:41:59 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-36-f4bug@amsat.org> <87lgncehbq.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5effed07-96c1-ae79-32a5-46b75516bf21@amsat.org>
Date: Tue, 25 Jul 2017 11:41:46 -0300
MIME-Version: 1.0
In-Reply-To: <87lgncehbq.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH for 2.10 35/35] script to run docker
 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

> This isn't appropriate for 2.10 now we are feature frozen. That said I

Surely. From the cover:

"... provided at the end of this series as RFC for people wanted
to give a try (also include 'dockershell' script and a fix in 
./configure). These RFC patches (33-35) are not expected to enter 2.10."

Peter also commented on the "./configure" patch, so I probably 
mis-titled "RFC" those patch

http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg07584.html:
"I prefixed this patch 'RFC' to not consider it but provide it
if someone wanted to reproduce the analysis. Maybe I should prefix it
'XXX' next time or 'NOT FOR MERGE'."

better "NOT FOR REVIEW" or "!RFC"? :p

> have pondered a helper script for this sort of thing before. As it stand
> I just rely on my shell to remember the correct invocation for me.
> 
> This is the sort of functionality we would need for maybe cross
> compiling tests using docker.

This script is way incomplete and far being finished.

Regards,

Phil.
