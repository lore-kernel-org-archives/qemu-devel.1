Received: from eggs.gnu.org ([209.51.188.92]:44191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1gwDkn-0006Ae-KN
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 17:20:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1gwDkm-0006Sd-L1
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 17:20:41 -0500
Date: Tue, 19 Feb 2019 22:20:28 +0000
From: Wei Yang <richard.weiyang@gmail.com>
Message-ID: <20190219222028.y3wt6bgihmx73ptw@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190219013106.17538-1-richardw.yang@linux.intel.com>
	<20190219013106.17538-3-richardw.yang@linux.intel.com>
	<ba83c335-c0f1-5190-33a9-f2f7f44c55f0@redhat.com>
	<77cf32b1-6a4a-33c5-4b3c-8ba3245a4b23@redhat.com>
	<2e584c55-5b40-4a29-b0ae-e53039e38a7d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e584c55-5b40-4a29-b0ae-e53039e38a7d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] CODING_STYLE: indent example code as
 all others
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, imammedo@redhat.com, mjt@tls.msk.ru

On Tue, Feb 19, 2019 at 07:55:31PM +0100, Philippe Mathieu-Daudé wrote:
>On 2/19/19 6:56 PM, Eric Blake wrote:
>> On 2/19/19 11:38 AM, Philippe Mathieu-Daudé wrote:
>> 
>>>> +    if (a == 1) {
>>>> +        /* Reads like: "If a equals 1" */
>>>
>>> I guess you found a bug in the documentation :)
>>>
>>> Since 8c06fbdf36bf4d the style asked is:
>>>
>>>     We now require Linux-kernel-style multiline comments:
>>>         /*
>>>          * line one
>>>          * line two
>>>          */
>>>
>>>> +        do_something();
>> 
>> We only require winged multiline comments when the comment is actually
>> multiline.  In this case, the comment is a one-liner, and is just fine
>> as written.
>
>Hmm I have a series where I moved code and changed from /* one line */
>to the multi-line style, I wonder why and remember checkpatch errors.
>Maybe a side-effect from what b94e809d3e fixed.
>
>Anyway, Wei do you mind adding a multi-line example here too?
>

A multi-line example for multiline comments?

This looks not relavant to this sectioin. I am afraid I will not add
this example here. Sorry for that.

>With/without multi-line example:
>Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>
>Thanks!
>
>Phil.

-- 
Wei Yang
Help you, Help me
