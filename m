Received: from eggs.gnu.org ([2001:4830:134:3::10]:47369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brandon.carpenter@cypherpath.com>)
	id 1dv3o7-0005fv-QT
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:54:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brandon.carpenter@cypherpath.com>)
	id 1dv3o4-0006xL-GT
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:54:31 -0400
Received: from mail-pf0-x230.google.com ([2607:f8b0:400e:c00::230]:50909)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brandon.carpenter@cypherpath.com>)
	id 1dv3o4-0006wr-5x
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:54:28 -0400
Received: by mail-pf0-x230.google.com with SMTP id m63so3410566pfk.7
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 08:54:27 -0700 (PDT)
Date: Thu, 21 Sep 2017 08:54:24 -0700
From: Brandon Carpenter <brandon.carpenter@cypherpath.com>
Message-Id: <1506009264.7363.0@smtp.gmail.com>
In-Reply-To: <20170921095528.GE26740@redhat.com>
References: <20170912152153.7729-1-brandon.carpenter@cypherpath.com>
	<1505926567.32618.0@smtp.gmail.com> <20170921095528.GE26740@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"; format=flowed
Subject: Re: [Qemu-devel] [PATCH v3 0/7] Update websocket code to more fully
 support the RFC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

Cool. Thanks for helping me through the process and for the great 
feedback.

--
Brandon Carpenter | Software Engineer
Cypherpath, Inc.
400 Columbia Point Drive Ste 101 | Richland, Washington USA
Office: (650) 713-3060

On Thu, Sep 21, 2017 at 2:55 AM, Daniel P. Berrange 
<berrange@redhat.com> wrote:
> On Wed, Sep 20, 2017 at 09:56:07AM -0700, Brandon Carpenter wrote:
>>  How are things looking, Daniel. I believe every comment from the 
>> previous
>>  version of the series was addressed.
>> 
>>  I also wanted to mention that I put together a Python script, which 
>> acts as
>>  a proxy between noVNC and qemu, and can inject various frame types, 
>> fragment
>>  frames, and shutdown the socket in various ways to help exercise the
>>  different code paths. I would be happy to post it here to help test 
>> the
>>  changes.
> 
> Sorry for the delay - I've reviewed this now and it looks good. I've 
> made a
> few whitespace changes in places, but I've queued it for my next pull 
> request
> now.
> 
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    
> https://www.instagram.com/dberrange :|

-- 


CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is 
for the sole use of the intended recipient(s) and may contain proprietary, 
confidential or privileged information or otherwise be protected by law. 
Any unauthorized review, use, disclosure or distribution is prohibited. If 
you are not the intended recipient, please notify the sender and destroy 
all copies and the original message.
