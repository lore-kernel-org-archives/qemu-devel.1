Received: from eggs.gnu.org ([2001:4830:134:3::10]:35526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dqN6X-0001Qs-9L
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 13:30:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dqN6W-0003PP-Ge
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 13:30:09 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20170830215523.25278-1-f4bug@amsat.org>
	<20170830215523.25278-13-f4bug@amsat.org>
	<9244c59c-569c-60b0-24e3-42a06f28d707@amsat.org>
	<48228e79-60a1-d773-4d52-aab18dd65010@amsat.org>
Message-ID: <72cc406e-a357-cc6d-70eb-6ba66a9db3b3@amsat.org>
Date: Fri, 8 Sep 2017 14:29:58 -0300
MIME-Version: 1.0
In-Reply-To: <48228e79-60a1-d773-4d52-aab18dd65010@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 12/17] MAINTAINERS: add missing megasas
 test entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Hannes Reinecke <hare@suse.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

Let's try another SUSE domain

On 09/08/2017 02:12 PM, Philippe Mathieu-Daudé wrote:
> I wonder if "megasas" is still maintained, I got:
> 
> To: Hannes Reinecke <hare@suse.de>
> Final-Recipient: rfc822; hare@suse.de
> Action: failed
> Status: 5.1.1
> Remote-MTA: dns; mx2.suse.de. (195.135.220.15, the server for the domain 
> suse.de.)
> Diagnostic-Code: smtp; 550 5.1.1 <hare@suse.de>: Recipient address 
> rejected: User unknown in local recipient table
> Last-Attempt-Date: Fri, 08 Sep 2017 06:04:54 -0700 (PDT)
> 
> For now I'll just drop this patch.
> 
> On 09/08/2017 10:04 AM, Philippe Mathieu-Daudé wrote:
>> ping?
>>
>> On 08/30/2017 06:55 PM, Philippe Mathieu-Daudé wrote:
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>>   MAINTAINERS | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index fa74b7254b..20d65dca73 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1118,6 +1118,7 @@ L: qemu-block@nongnu.org
>>>   S: Supported
>>>   F: hw/scsi/megasas.c
>>>   F: hw/scsi/mfi.h
>>> +F: tests/megasas-test.c
>>>   Network packet abstractions
>>>   M: Dmitry Fleytman <dmitry@daynix.com>
>>>
