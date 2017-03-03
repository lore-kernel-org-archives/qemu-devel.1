Received: from eggs.gnu.org ([2001:4830:134:3::10]:42821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjsHj-0007Iq-FK
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:50:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjsHi-0005kj-QB
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:50:35 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:37834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjsHi-0005kZ-IG
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:50:34 -0500
Received: by mail-wm0-x235.google.com with SMTP id n11so22330336wma.0
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 10:50:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87pohykxzt.fsf@dusky.pond.sub.org>
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
	<CAFEAcA-XqZb22ov-PxxGJ8EnF-Yj+m-FETPY0n1kUcZDmskqxA@mail.gmail.com>
	<87pohykxzt.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Mar 2017 18:50:12 +0000
Message-ID: <CAFEAcA_7Lc8A3vOvCLrdk4FgfSGf1-o4JrCv7=c-hN2jK=h+Ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 00/15] block: A bunch of fixes for Sheepdog
 and Gluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Jeff Cody <jcody@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, namei.unix@gmail.com

On 3 March 2017 at 18:37, Markus Armbruster <armbru@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>> Did you find these by looking at our Coverity results, or
>> cross-reference them against Coverity? (Coverity definitely
>> found the gluster leaks, for instance.)
>
> Neither.  I merely hacked myself a path through an unfamliar jungle :)

OK; I guess we'll see how many of the coverity nits get fixed :-)

thanks
-- PMM
