Received: from eggs.gnu.org ([2001:4830:134:3::10]:45812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e2ehm-0003Pi-AP
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 10:43:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e2ehg-0006P6-QH
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 10:43:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e2ehg-0006OI-Jy
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 10:43:16 -0400
References: <CAFEAcA81AZBaGu6nrLK51_6vWApMSpMDhb9OsnkdApMGebYK8w@mail.gmail.com>
	<20171012140159.GA11619@localhost.localdomain>
	<CAFEAcA-8tZZFL=tjgy=XFsoo=MiJ0EE_96j9amV-4aoVZ3vN2w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7ae4f005-0385-912a-6095-65c62800e3e7@redhat.com>
Date: Thu, 12 Oct 2017 16:42:58 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-8tZZFL=tjgy=XFsoo=MiJ0EE_96j9amV-4aoVZ3vN2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qemu.org: new git repos to be mirrored
 (qemu-palcode, capstone, keycodemapdb)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Jeff Cody <jcody@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Richard Henderson <rth@twiddle.net>

On 12/10/2017 16:16, Peter Maydell wrote:
> On 12 October 2017 at 15:01, Jeff Cody <jcody@redhat.com> wrote:
>> Done.
> 
> Great, thanks.

... and the github mirrors too.

Paolo

>> The git.qemu.org URLs are:
>>
>> git://git.qemu.org/capstone.git
>> https://git.qemu.org/git/capstone.git
>>
>> git://git.qemu.org/keycodemapdb.git
>> https://git.qemu.org/git/keycodemapdb.git
>>
>> git://git.qemu.org/qemu-palcode.git
>> https://git.qemu.org/git/qemu-palcode.git
>>
>>
>> And of course they can also be viewed via the gitweb interface:
>>
>> https://git.qemu.org/
>>
>>
>> I have NOT set these to push to our github mirror account, since I assume it
>> is read-only.  Would you prefer I go ahead and mirror them there as well,
>> anyway?
> 
> We don't need them to be on  github, but on the other hand looking at
> the github page https://github.com/qemu/ we seem to generally
> have our other mirrors (eg u-boot, dtc) also pushed to github.
> So I don't mind but we should I guess aim for consistency.
> 
> thanks
> -- PMM
> 
