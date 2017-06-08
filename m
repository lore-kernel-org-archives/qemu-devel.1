Received: from eggs.gnu.org ([2001:4830:134:3::10]:35446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dIwyu-00037o-V7
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 08:56:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dIwyu-00021C-4P
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 08:56:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dIwyt-000210-UC
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 08:56:08 -0400
References: <1496899257-25800-1-git-send-email-thuth@redhat.com>
	<87shjbj6y9.fsf@dusky.pond.sub.org>
	<424f8720-7bf6-33b1-f6a5-a8ed3494a648@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4339634c-00d0-0bfd-8da7-6013c759da82@redhat.com>
Date: Thu, 8 Jun 2017 14:56:02 +0200
MIME-Version: 1.0
In-Reply-To: <424f8720-7bf6-33b1-f6a5-a8ed3494a648@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vl: Fix broken thread=xxx option of the
 --accel parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Emilio G Cota <cota@braap.org>

On 08.06.2017 14:53, Paolo Bonzini wrote:
> 
> 
> On 08/06/2017 09:04, Markus Armbruster wrote:
>> The fix is fine, so
>>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 
> Who's going to merge it?

Could you do it, Paolo? You also merged my commit bde4d9205 that
introduced this bug...

 Thomas
