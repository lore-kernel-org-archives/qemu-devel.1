Received: from eggs.gnu.org ([2001:4830:134:3::10]:46981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fDgel-0006Tg-Oy
	for qemu-devel@nongnu.org; Tue, 01 May 2018 21:34:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fDgei-0007Nm-MO
	for qemu-devel@nongnu.org; Tue, 01 May 2018 21:34:07 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:38185)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1fDgei-0007NX-EH
	for qemu-devel@nongnu.org; Tue, 01 May 2018 21:34:04 -0400
Received: by mail-pg0-x242.google.com with SMTP id n9-v6so9421986pgq.5
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 18:34:04 -0700 (PDT)
References: <87o9inxkd1.fsf@dusky.pond.sub.org>
	<20180430065235.577-1-aik@ozlabs.ru>
	<115942c3-ac74-7cc2-6683-98a6dffc7d6c@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <0a7925a5-0278-607f-5c71-3c13de052789@ozlabs.ru>
Date: Wed, 2 May 2018 11:33:58 +1000
MIME-Version: 1.0
In-Reply-To: <115942c3-ac74-7cc2-6683-98a6dffc7d6c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] qom: Document
 qom/device-list-properties implementation specific
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 1/5/18 11:01 pm, Eric Blake wrote:
> On 04/30/2018 01:52 AM, Alexey Kardashevskiy wrote:
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
> 
> There is no rationale in the commit body (a good commit message has a
> one-line summary of "what", then a paragraph stating "why", making it
> easier for the reviewer to check that the patch itself is the "how" that
> matches the commit message).

Posting it in the existing thread is the rationale which explains better :)
I should have made it "rfc" though as it is not really a patch but rather
an email asking for comments.

> Also, when sending a new patch, it's best to send it as a new top-level
> thread, rather than in-reply-to an older thread that has already seen
> review commentary (otherwise, it's likely to get missed in the noise).

Well, normally it is fine but the context would be lost so lots need to be
put to the commit log and I can see how the whole patch is dropped as
useless after all. I am not arguing, just explaining :)



-- 
Alexey
