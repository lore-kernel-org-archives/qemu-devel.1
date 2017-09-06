Received: from eggs.gnu.org ([2001:4830:134:3::10]:44703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpUL9-0004EI-2Y
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 03:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpUL8-0005z9-CV
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 03:01:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dpUL8-0005x9-6U
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 03:01:34 -0400
References: <CAO6-N=a7WwhsDqZsm=wppXWMunGub=RH17FBk5w_tK0vu-8=cQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d7a01a3e-a9fd-9e05-f3de-267e5d76e59a@redhat.com>
Date: Wed, 6 Sep 2017 09:01:30 +0200
MIME-Version: 1.0
In-Reply-To: <CAO6-N=a7WwhsDqZsm=wppXWMunGub=RH17FBk5w_tK0vu-8=cQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] stack smash while using SDL 1.2.5 with QEMU 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Taimoor Mirza <taimoor.mrza@gmail.com>, qemu-devel <qemu-devel@nongnu.org>

On 21.08.2017 15:02, Taimoor Mirza wrote:
> Hi Guys,
> 
> I have been using QEMU 1.5 earlier with SDL version 1.2.5. Now we have
> decided to move to new version of QEMU. I have built QEMU binaries with SDL
> support using SDL 1.2.5 that we were using earlier.
SDL 1.2.5 is incredibly old - it has been released 2002. Could you
please try with a newer version instead (i.e. version 1.2.15 from 2012,
or even upgrade to SDL2)?

 Thomas
