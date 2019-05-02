Received: from eggs.gnu.org ([209.51.188.92]:46916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hM2RB-00048G-9t
	for qemu-devel@nongnu.org; Wed, 01 May 2019 23:31:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hM2R9-0004zY-SA
	for qemu-devel@nongnu.org; Wed, 01 May 2019 23:31:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hM2R9-0004D2-J2
	for qemu-devel@nongnu.org; Wed, 01 May 2019 23:31:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id l2so1121720wrb.9
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 20:29:25 -0700 (PDT)
References: <20190425145420.8888-1-stefanha@redhat.com>
	<CAJ+F1CLYjF8SQv0v8c-hfbPcFYgZdg1P-MVeB8nS_AXTy4eMDA@mail.gmail.com>
	<20190501170647.GC22391@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7d652656-121a-ca3d-0bc8-31638f0144ac@redhat.com>
Date: Thu, 2 May 2019 05:29:22 +0200
MIME-Version: 1.0
In-Reply-To: <20190501170647.GC22391@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] gitmodules: use qemu.org git mirrors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

On 5/1/19 7:06 PM, Stefan Hajnoczi wrote:
> On Tue, Apr 30, 2019 at 04:53:08PM +0200, Marc-André Lureau wrote:
>> Hi
>>
>> On Thu, Apr 25, 2019 at 4:54 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>>
>>> qemu.org hosts git repository mirrors of all submodules.  Update
>>> .gitmodules to use the mirrors and not the upstream repositories.
>>>
>>> Mirroring upstream repositories ensures that QEMU continues to build
>>> even when upstream repositories are deleted or temporarily offline.
>>>
>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>
>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>
>> Stefan, do you prepare a pullreq?
> 
> This patch isn't within the scope of my block or tracing trees.

Peter often applies those patches directly, see:
https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg02073.html

> 
> Perhaps Peter is willing to apply it?
> 
> Stefan
> 
