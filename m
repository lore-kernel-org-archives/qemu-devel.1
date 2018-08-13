Received: from eggs.gnu.org ([2001:4830:134:3::10]:54753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdenber@gmx.com>) id 1fpIR2-0007vY-99
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 15:23:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdenber@gmx.com>) id 1fpIQz-0002O5-22
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 15:23:24 -0400
Received: from mout.gmx.net ([212.227.17.21]:39263)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mdenber@gmx.com>) id 1fpIQy-0002Nq-Ow
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 15:23:20 -0400
References: <5B7054D9.9000209@gmx.com> <20180813083408.GG22904@redhat.com>
	<CAEgYsbEQpnVn-hWgQxBmCfiTnU7eOdA+sdscpAHo=+KH17bnuA@mail.gmail.com>
From: Michele Denber <mdenber@gmx.com>
Message-ID: <5B71DAA0.4040205@gmx.com>
Date: Mon, 13 Aug 2018 15:23:12 -0400
MIME-Version: 1.0
In-Reply-To: <CAEgYsbEQpnVn-hWgQxBmCfiTnU7eOdA+sdscpAHo=+KH17bnuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QEMU on Solaris
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Tribble <peter.tribble@gmail.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 08-13-2018 6:08 AM, Peter Tribble wrote:
>
>
> From the point of view of software such as qemu, divergences should be 
> slight
> (there are going to be changes around packaging, shipped compilers, 
> but that's
> true for different Linux distros in the same family). If it builds and 
> works on
> Solaris, it'll build and work on one of the illumos distributions, and 
> vice versa.
> (Although I note that's Solaris 10 mentioned above, which is now EOL, and
> may be a little more problematic due to its age.)
I'm still using Solaris 10 because upgrading to Solaris 11 is a giant 
pain, and they did away with the Java Desktop Environment GUI in 11.  I 
really like the JDE.  However, I believe that Solaris 10 programs should 
also work in Solaris 11.  And it looks like Solaris 11 may be the end of 
the line anyway.
>
> You can certainly run illumos (such as OpenIndiana or Tribblix) in a 
> VM easily,
> and freely. I can help with that.
>
> That's for x86, of course. Building on a SPARC platform is a different 
> matter
> entirely. (Although that's one of the reasons some of us are 
> interested in qemu
> in the first place.)
That's exactly why I'm interested.  I'd like to declare my independence 
form Microsoft and Windows but I still have a few important Windows 
programs that won't run on anything else.  One can debate Solaris vx. 
Linux, but I've made my choice.

             - Michele
