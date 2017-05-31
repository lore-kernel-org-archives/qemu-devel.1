Received: from eggs.gnu.org ([2001:4830:134:3::10]:53087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dG4Bj-0006ot-En
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:01:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dG4Bf-0004zg-9Y
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:01:27 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:33814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dG4Bf-0004zY-5I
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:01:23 -0400
Received: by mail-oi0-x241.google.com with SMTP id w10so2021304oif.1
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 07:01:22 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170529084546.26500-1-marcandre.lureau@redhat.com>
	<20170529084546.26500-15-marcandre.lureau@redhat.com>
	<436727fa-d35c-cfa9-52b3-f59e58a92bb7@amsat.org>
	<9a17ac0d-fd7f-8c50-4682-72ef205d80db@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6a42af36-58f4-97c6-5beb-600740a5ae9e@amsat.org>
Date: Wed, 31 May 2017 11:01:19 -0300
MIME-Version: 1.0
In-Reply-To: <9a17ac0d-fd7f-8c50-4682-72ef205d80db@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 14/14] char: move char devices to
 chardev/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

On 05/30/2017 12:18 PM, Eric Blake wrote:
> On 05/29/2017 04:31 PM, Philippe Mathieu-Daudé wrote:
>> On 05/29/2017 05:45 AM, Marc-André Lureau wrote:
>>> Suggested by Paolo Bonizini during series review.
>>
>> Bonzini ;) "serie" singular
>
> No, "serie" is not a word.  "series" is one of those weird English words
> that is both singular and plural (another such word is "sheep").

Oh, I thought it was describing "this" particular series so no need to 
plural. Thank for the clarification :)
