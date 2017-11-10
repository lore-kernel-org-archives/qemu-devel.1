Received: from eggs.gnu.org ([2001:4830:134:3::10]:37776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eD89h-0007Qy-Og
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 07:11:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eD89g-0006rz-Bc
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 07:11:29 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1510228971-6005-1-git-send-email-sundeep.lkml@gmail.com>
	<4beb4e47-0ff9-8251-6502-23824779edbd@amsat.org>
	<CAFEAcA-ATtAougvALVo=48p+jVx5B+Ejq60TD9dGYEQU2ReWCQ@mail.gmail.com>
	<5a7b721c-fe04-921b-b9d2-986c9930b00b@amsat.org>
	<CALHRZuroyXXzxcWW0XX5fzQ9m8Zh0oZy8RivtiQjzKdHoxQ9WQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d3271bd0-41a9-90b5-c84b-e8ba9ec1585c@amsat.org>
Date: Fri, 10 Nov 2017 09:11:17 -0300
MIME-Version: 1.0
In-Reply-To: <CALHRZuroyXXzxcWW0XX5fzQ9m8Zh0oZy8RivtiQjzKdHoxQ9WQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu devel PATCH] MAINTAINERS: Add entries for
 Smartfusion2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sundeep subbaraya <sundeep.lkml@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair23@gmail.com>

Hi Sundeep, Peter.

>     On 11/09/2017 08:55 PM, Peter Maydell wrote:
>     > On 9 November 2017 at 21:46, Philippe Mathieu-Daudé <f4bug@amsat.org <mailto:f4bug@amsat.org>> wrote:
>     >> Hi Subbaraya,
>     >>
>     >> On 11/09/2017 09:02 AM, Subbaraya Sundeep wrote:
>     >>> add voluntarily myself as maintainer for Smartfusion2
>     >>
>     >> You need to share your GnuPG key signed, I couldn't find it using
>     >> http://pgp.mit.edu/pks/lookup?search=Subbaraya+Sundeep
>     <http://pgp.mit.edu/pks/lookup?search=Subbaraya+Sundeep>
>     >>
>     >> from https://wiki.qemu.org/Contribute/SubmitAPullRequest
>     <https://wiki.qemu.org/Contribute/SubmitAPullRequest> :
>     >
>     > I don't in general expect to take pull requests from
>     > everybody listed as a maintainer in the MAINTAINERS file.
>     > That just means "I'm going to be reviewing and should
>     > be cc'd on patches". Pull requests are sent by people
>     > who are maintainers for a subsystem. Rule of thumb:
>     > unless somebody asks you to send a pull request, you
>     > don't need to do it.
> 
>     Ok, please apologize my misunderstanding. I still think the M: entry

Peter: Oops :) read "I apologize"

>     stand for 'Maintainer' instead of 'Mail', and still don't understand the
>     difference with a "Designated reviewer" (R: entry):
> 
>             M: Mail patches to: FullName <address@domain>
>             R: Designated reviewer: FullName <address@domain>
>                These reviewers should be CCed on patches.
> 
>     "Designated reviewer" seems to duplicate the M: entry and is therefore
>     confusing. Can we simply remove it instead?
> 
>     When introduced in fdf6fab4df4 the explanation was:
> 
>     --
>     Some people are not content with the amount of mail they get, and would
>     like to be CCed on patches for areas they do not maintain.  Let them
>     satisfy their own appetite for qemu-devel messages.
> 
>     Seriously: the purpose here is a bit different from the Linux kernel.
>     While Linux uses "R" to designate non-maintainers for reviewing patches
>     in a given area, in QEMU I would also like to use "R" so that people can
>     delegate sending pull requests while keeping some degree of oversight.
>     --
> 
> Do you want me to remove M: and put only R: ?

No, it seems you are correct and I was wrong :)

If you agree changing the first section title to "SmartFusion2" and
eventually the second to "Emcraft M2S-FG484":

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Regards,

Phil.
